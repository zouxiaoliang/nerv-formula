class GrpcAT126X < Formula
  desc "Next generation open source RPC library and framework"
  homepage "https://grpc.io/"
  url "https://github.com/grpc/grpc.git", :tag => "v1.26.x"
  head "https://github.com/grpc/grpc.git"
  version "v1.26.x"
  
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "shtool" => :build
  depends_on "gflags" => :build
  depends_on "protobuf"

  def install
    # how to build grpc v1.26.x
    ENV["LIBTOOL"] = "glibtool"
    ENV["LIBTOOLIZE"] = "glibtoolize"
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "false"
  end
end
