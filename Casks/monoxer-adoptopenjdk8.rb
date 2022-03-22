cask "monoxer-adoptopenjdk8" do
  version "8,292,b10"
  sha256 "4e200bc752337abc9dbfddf125db6a600f2ec53566f6f119a83036c8242a7672"

  url "https://github.com/AdoptOpenJDK/openjdk#{version.csv[0}-binaries/releases/download/jdk#{version.csv[0]}u#{version.csv[1]}-b#{version.csv[2]}/OpenJDK#{version.csv[0]}U-jdk_x64_mac_hotspot_#{version.csv[0]}u#{version.csv[1]}b#{version.csv[2]}.pkg",
      verified: "https://github.com/AdoptOpenJDK"
  name "AdoptOpenJDK 8"
  desc "AdoptOpenJDK OpenJDK (Java) Development Kit"
  homepage "https://adoptopenjdk.net/"

  livecheck do
    url "https://github.com/adoptopenjdk/openjdk#{version.csv[0]}-binaries/releases/latest"
    strategy :page_match do |page|
      page.scan(/href=.*jdk(#{version.csv[0]})u(#{version.csv[1]})-(#{version.csv[2]})/i)
          .map { |match| "#{match[0]},#{match[1]},#{match[2]}" }
    end
  end

  pkg "OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.pkg"

  postflight do
    system_command "/usr/sbin/pkgutil", args: ["--pkg-info", "net.adoptopenjdk.8.jdk"], print_stdout: true
  end

  uninstall pkgutil: "net.adoptopenjdk.8.jdk"
end
