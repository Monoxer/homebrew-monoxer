cask "monoxer-adoptopenjdk8" do
  version "8.292,b10"
  sha256 "4e200bc752337abc9dbfddf125db6a600f2ec53566f6f119a83036c8242a7672"

  url "https://github.com/AdoptOpenJDK/openjdk#{version.major}-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.pkg",
      verified: "https://github.com/AdoptOpenJDK"
  name "AdoptOpenJDK 8"
  desc "AdoptOpenJDK OpenJDK (Java) Development Kit"
  homepage "https://adoptopenjdk.net/"

  livecheck do
    url "https://github.com/adoptopenjdk/openjdk#{version.major}-binaries/releases/latest"
    strategy :page_match do |page|
      page.scan(/href=.*jdk(#{version.major})u(#{version.minor})-(#{version.csv.second})/i)
          .map { |match| "#{match[0]}.#{match[1]},#{match[2]}" }
    end
  end

  pkg "OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.pkg"

  postflight do
    system_command "/usr/sbin/pkgutil", args: ["--pkg-info", "net.adoptopenjdk.8.jdk"], print_stdout: true
  end

  uninstall pkgutil: "net.adoptopenjdk.8.jdk"
end
