require "formula"

class Fly < Formula
  homepage "https://github.com/concourse/fly"
  head "https://github.com/concourse/fly.git", :branch => "master"

  depends_on "go" => :build
  depends_on "godep" => :build

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/concourse/fly"
    system "rsync", "-avR", "--exclude", "src", "./", "src/github.com/concourse/fly"

    system "godep", "go", "build", "-o", "out/fly", "github.com/concourse/fly"

    bin.install "out/fly"
  end

  test do
    system "#{bin}/fly", "--version"
  end
end
