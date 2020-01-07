class Zipper < Formula
  desc "C++ wrapper around minizip compression library"
  homepage "https://github.com/sebastiandev/zipper"
  url "https://github.com/sebastiandev/zipper.git", :tag => "v1.0.1"
  head "https://github.com/sebastiandev/zipper.git"
  version "v1.0.1"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "false"
  end
end
