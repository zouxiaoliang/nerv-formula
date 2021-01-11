class FlexibleNetwork < Formula
  desc "async netowrl utils base on boost asio"
  homepage "https://gitee.com/www.evangerlion.com/flexible-network.git" 
  url "https://gitee.com/www.evangerlion.com/flexible-network.git" 
  head "https://gitee.com/www.evangerlion.com/flexible-network.git", :branch => "brew"
  version "0.0.1"
  
  depends_on "boost" => :build
  depends_on "cmake" => :build

  # def install
  #   mkdir "build" do
  #     system "cmake", "..", "-DCMAKE_INSTALL_PREFIX=#{prefix}"
  #     system "make", "-j2"
  #     system "make", "install"
  #   end
  # end

  # test do
  #   system "false"
  # end
end