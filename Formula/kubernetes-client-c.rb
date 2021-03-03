class KubernetesClientC < Formula
    desc "This is the official Kubernetes client library for the C programming language. It is a work in progress and should be considered alpha quality software at this time."
    homepage "https://github.com/kubernetes-client/c"
    url "https://github.com/kubernetes-client/c.git"
    head "https://github.com/kubernetes-client/c.git"
    version "master"
    
    depends_on "cmake"
    depends_on "curl"
    depends_on "openssl"
    depends_on "uncrustify"
    depends_on "libyaml"
  
    def patch
      unless File.exists? "CMakeLists.txt"
        return
      end
      system "mv", "CMakeLists.txt", "CMakeLists.txt.source"
      lines = (File.read File.open "CMakeLists.txt.source", "r").split "\n"
      writer = File.open "CMakeLists.txt" , "w"
      append_library = false
      append_install_include = false
      lines.each do | line |
        
        unless append_library
          cmake_cmdline = line.strip
          if cmake_cmdline.start_with? "target_link_libraries" and cmake_cmdline.end_with? ")"
            
            writer.write "if (APPLE)\n"
            writer.write "    add_definitions(-Dsecure_getenv=getenv)\n"
            writer.write "endif(APPLE)\n"
            
            line = "if (APPLE)\n    #{line.gsub ")", "libssl.a libcrypto.a yaml)"}\nelse()\n    #{line}\nendif(APPLE)\n"
            append_library = true
          end
        end
        
        unless append_install_include
          cmake_cmdline = line.strip
          if cmake_cmdline.start_with? "install"
            line = "install(TARGETS ${pkgName} DESTINATION )

file(GLOB HEAD_FILES \"include/*.h\")
message(STATUS \"head files: ${PUBLIC_HEAD_FILES}\")
install(FILES ${HEAD_FILES} DESTINATION include/kubernetes-c/include )

file(GLOB API_HEAD_FILES \"api/*.h\")
message(STATUS \"head files: ${API_HEAD_FILES}\")
install(FILES ${API_HEAD_FILES} DESTINATION include/kubernetes-c/api )

file(GLOB CONFIG_HEAD_FILES \"config/*.h\")
message(STATUS \"head files: ${CONFIG_HEAD_FILES}\")
install(FILES ${CONFIG_HEAD_FILES} DESTINATION include/kubernetes-c/config )

file(GLOB MODEL_HEAD_FILES \"model/*.h\")
message(STATUS \"head files: ${MODEL_HEAD_FILES}\")
install(FILES ${MODEL_HEAD_FILES} DESTINATION include/kubernetes-c/model )

file(GLOB EXTERNAL_HEAD_FILES \"external/*.h\")
message(STATUS \"head files: ${EXTERNAL_HEAD_FILES}\")
install(FILES ${EXTERNAL_HEAD_FILES} DESTINATION include/kubernetes-c/external )"
            append_install_include = true
          end
        end
        
        writer.write "#{line}\n"
      end
       
      writer.flush
      writer.close
    end

    def install
      cd "kubernetes" do
        patch
        puts "install to #{prefix} ..."
        system "cmake", "-DCMAKE_INSTALL_PREFIX=#{prefix}"
        system "make"
        system "make", "install"
      end
    end
  
    test do
      system "false"
    end
  end
  
