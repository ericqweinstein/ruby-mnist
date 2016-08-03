#!/usr/bin/env ruby -w

require 'ruby-fann'
require_relative './mnist'
require_relative './cropper'
require_relative './util'

TRAIN_SIZE = 60_000
TEST_SIZE = 10_000
HIDDEN_NEURONS = 300
IMAGE_DIMENSION = 24
OUTPUTS = 10

puts 'Loading training data...'
x_train, y_train = Mnist.training_set.data_and_labels TRAIN_SIZE

x_train.map! { |row| Cropper.new(row).random_square_crop(IMAGE_DIMENSION).to_a.flatten }

train = RubyFann::TrainData.new(inputs: x_train, desired_outputs: y_train)
fann = RubyFann::Standard.new(num_inputs: IMAGE_DIMENSION * IMAGE_DIMENSION,
                              hidden_neurons: [HIDDEN_NEURONS],
                              num_outputs: OUTPUTS)

puts "Training network with #{TRAIN_SIZE} examples..."
t = Time.now

# 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error).
fann.train_on_data(train, 1000, 10, 0.01)
puts "Training time: #{(Time.now - t).round(1)}s"

puts "\nLoading test data..."
x_test, y_test = Mnist.test_set.data_and_labels TEST_SIZE
x_test.map! { |row| Cropper.new(row).random_square_crop(IMAGE_DIMENSION).to_a.flatten }

def error_rate(errors, total)
  ((errors / total.to_f) * 100).round
end

def mse(actual, ideal)
  errors = actual.zip(ideal).map { |a, i| a - i }
  (errors.reduce(0) { |a, e| a + e**2 }) / errors.length.to_f
end

def prediction_success(actual, ideal)
  Util.decode_output(actual) == Util.decode_output(ideal)
end

def run_test(nn, inputs, expected_outputs)
  success, failure, errsum = Array.new(3, 0)

  inputs.each.with_index do |input, i|
    output = nn.run input
    prediction_success(output, expected_outputs[i]) ? success += 1 : failure += 1
    errsum += mse(output, expected_outputs[i])
  end

  [success, failure, errsum / inputs.length.to_f]
end

puts "Testing the trained network with #{TEST_SIZE} examples..."

success, failure, avg_mse = run_test(fann, x_test, y_test)

puts "Trained classification success: #{success}, failure: #{failure} (classification error: #{error_rate(failure, x_test.length)}%, mse: #{(avg_mse * 100).round(2)}%)"

filename = 'data/nn.data'
puts "Saving neural network to file: #{filename}"
fann.save(filename)
