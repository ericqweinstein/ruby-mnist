require 'zlib'
require_relative 'util'

# Handles loading the MNIST dataset.
# @see http://yann.lecun.com/exdb/mnist/
class Mnist
  class << self
    def training_set
      new './data/train-images-idx3-ubyte.gz', './data/train-labels-idx1-ubyte.gz'
    end

    def test_set
      new './data/t10k-images-idx3-ubyte.gz', './data/t10k-labels-idx1-ubyte.gz'
    end
  end

  def initialize(images_file, labels_file)
    @images_file = images_file
    @labels_file = labels_file
  end

  def data_and_labels(size)
    load_data
    x_data = []
    y_data = []

    @data.slice(0, size).each do |row|
      image = row[0].unpack('C*')
      image = image.map { |v| Util.normalize(v, 0, 256, 0, 1) }
      x_data << image
      y_data << row[1]
    end

    [x_data, y_data]
  end

  private

  def load_data
    n_rows = nil
    n_cols = nil
    images = []
    labels = []

    Zlib::GzipReader.open(@images_file) do |f|
      _, n_images = f.read(8).unpack('N2')
      n_rows, n_cols = f.read(8).unpack('N2')
      n_images.times { images << f.read(n_rows * n_cols) }
    end

    Zlib::GzipReader.open(@labels_file) do |f|
      _, n_labels = f.read(8).unpack('N2')
      labels = f.read(n_labels).unpack('C*')
    end

    # Collate image and label data.
    @data = images.map.with_index do |image, i|
      target = Array.new(10, 0)
      target[labels[i]] = 1
      [image, target]
    end
  end
end
