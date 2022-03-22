cask "monoxer-adoptopenjdk8" do
  version "8,292:b10"
  sha256 "4e200bc752337abc9dbfddf125db6a600f2ec53566f6f119a83036c8242a7672"

  # github.com/AdoptOpenJDK was verified as official when first introduced to the cask
  url "https://github.com/AdoptOpenJDK/openjdk#{version.before_comma}-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.pkg",
      verified: "https://github.com/AdoptOpenJDK"
  appcast "https://github.com/adoptopenjdk/openjdk#{version.before_comma}-binaries/releases/latest"
  name "AdoptOpenJDK 8"
  desc "AdoptOpenJDK OpenJDK (Java) Development Kit"
  homepage "https://adoptopenjdk.net/"

  pkg "OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.pkg"

  postflight do
    system_command "/usr/sbin/pkgutil", args: ["--pkg-info", "net.adoptopenjdk.8.jdk"], print_stdout: true
  end

  uninstall pkgutil: "net.adoptopenjdk.8.jdk"
end