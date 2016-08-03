require 'base64'
require 'chunky_png'
require 'json'
require 'ruby-fann'
require 'sinatra'
require_relative './lib/util'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/submit' do
  canvas = downsample ChunkyPNG::Canvas.from_data_url(request.body.read)
  random_cropped = Array.new(4) { canvas.crop(rand(5), rand(5), 24, 24) }
  predict_sums = Array.new(10, 0)
  fann = RubyFann::Standard.new(filename: './data/nn.data')

  random_cropped.each do |cropped|
    pixels = normalize_pixels cropped
    predict = fann.run pixels
    predict.each_with_index { |val, i| predict_sums[i] += val }
  end

  { prediction: Util.decode_output(predict_sums) }.to_json
end

private

def downsample(canvas)
  canvas.trim!
  size = [canvas.width, canvas.height].max
  square = ChunkyPNG::Canvas.new(size, size, ChunkyPNG::Color::TRANSPARENT)
  offset_x = find_offset(size, canvas.width)
  offset_y = find_offset(size, canvas.height)
  square.compose!(canvas, offset_x, offset_y)
  square.resample_bilinear!(20, 20)
  square.tap { |s| s.border!(4, ChunkyPNG::Color::TRANSPARENT) }
end

def find_offset(size, dimension)
  (size - dimension) / 2.0
end

def normalize_pixels(canvas)
  pixels = []
  24.times { |y| 24.times { |x| pixels << canvas[x, y] } }
  min = pixels.min
  max = pixels.max
  pixels.tap { |pix| pix.map { |p| Util.normalize(p, min, max, 0, 1) } }
end
