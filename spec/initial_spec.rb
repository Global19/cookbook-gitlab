require 'spec_helper'

describe "gitlab::initial" do
  let(:chef_run) { ChefSpec::Runner.new.converge("gitlab::initial") }

  before do
    # stubbing git commands because initial recipe requires gitlab::git
    stub_command("test -f /var/chef/cache/git-1.7.12.4.zip").and_return(true)
    stub_command("git --version | grep 1.7.12.4").and_return(true)
  end

  describe "under ubuntu 12.04" do
    let(:chef_run) { ChefSpec::Runner.new(platform: "ubuntu", version: "12.04").converge("gitlab::initial") }

    it "installs all default packages" do
      packages = chef_run.node['gitlab']['packages']
      packages.each do |pkg|
        expect(chef_run).to install_package(pkg)
      end
    end
  end
end
