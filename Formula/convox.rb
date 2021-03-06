class Convox < Formula
  desc "The convox AWS PaaS CLI tool"
  homepage "https://convox.com/"
  url "https://github.com/convox/rack/archive/20170315195000.tar.gz"
  sha256 "9fbfae20b789503d6d7b27c67e0c85bbadce5bab7161037b1af20ab30ab3a688"

  bottle do
    cellar :any_skip_relocation
    sha256 "81a4318502e58d47a6fc85ae872572597ffcca4c0333f6e43cc0dfe889981b2a" => :sierra
    sha256 "99ae3cdc0eb89abfa869577492a3e4960e9e30551d973fd36c225c6a9d146d9a" => :el_capitan
    sha256 "4aa95f0eed18e9c47286784180696129e0bdf40e965e30f327c6b7030f2b4e00" => :yosemite
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/convox/rack").install Dir["*"]
    system "go", "build", "-ldflags=-X main.Version=#{version}",
           "-o", bin/"convox", "-v", "github.com/convox/rack/cmd/convox"
  end

  test do
    system bin/"convox"
  end
end
