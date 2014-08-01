require 'spec_helper'

#hostname test
#ホスト名を編集してください
describe command('hostname') do
  it { should return_stdout 'test'}
end

#/etc/hosts test
#IP アドレスとホスト名を編集してください
describe file('/etc/hosts') do
  it { should contain '10.50.95.1 test'}
end

#redhat-release test
#redhat-release のバージョン番号を編集してください
describe file('/etc/redhat-release') do
  it { should contain "CentOS release 6.4 (Final)" }
end

#x86 test
#32bit のときは i386
#64bit のときは x86_64
describe command('uname -a') do
  it { should return_stdout /.+x86_64.+/ }
end

#lang test
#日本語以外の場合は編集してください
describe file('/etc/sysconfig/i18n') do
  it { should contain 'LANG="ja_JP.UTF-8"' }
end

#keybordtype test
describe file('/etc/sysconfig/keyboard') do
  it { should contain 'KEYTABLE="jp106"' }
end

#timezone test
describe command('date') do
  it { should return_stdout /.*JST.*/ }
end

#cpu test
#2core の時は /processor.+\:.+1/
#4core の時は /processor.+\:.+3/
describe command('cat /proc/cpuinfo') do
  #it { should contain "processor       : 0" }
  it { should return_stdout /processor.+\:.+0/ }
end

#memory test
#数字に誤差が発生するので失敗するかも
#1G 1020820 kB
#4G 3922928 kB
describe file('/proc/meminfo') do
  it { should contain "MemTotal:        1020820 kB"}
end

#HDD test
#/boot は 250M で作成しても 243M と表示される
#/ は 50G で作成しても 48G と表示される
#100G 97G
describe command('df -h') do
  it { should return_stdout /\/dev\/vda1.+243M.+\/boot/ }
  it { should return_stdout /\/dev\/vda3.+48G.+\// }
end

#/etc/fstab check
#追記を行った場合、内容を正規表現で記述してください
#共有ストレージを使う場合は最終行のコメントアウトを外して編集してください
describe command('cat /etc/fstab') do
  it { should return_stdout /.*\/.*ext4.+defaults.*1.*1/ }
  it { should return_stdout /.*\/boot.*ext4.+defaults.*1.*2/ }
  it { should return_stdout /.*swap.*swap.*defaults.*0.*0/ }
  it { should return_stdout /tmpfs.*\/dev\/shm.*tmpfs.*defaults.*0.*0/ }
  it { should return_stdout /devpts.*\/dev\/pts.*devpts.*gid=5,mode=620.*0.*0/ }
  it { should return_stdout /sysfs.*\/sys.*sysfs.*defaults.*0.*0/ }
  it { should return_stdout /proc.*\/proc.*proc.*defaults.*0.*0/ }
  #it { should return_stdout /10.0.0.0\:\/ifs\/home\/nfs.*\/external.*nfs.*bg,nfsvers=3,intr,tcp,hard,retrans=1.*0.*0/ }
end

#eth0 test
#IPADDR を編集してください
describe file('/etc/sysconfig/network-scripts/ifcfg-eth0') do
  it { should be_file }
  it { should contain 'DEVICE="eth0"' }
  it { should contain 'BOOTPROTO="static"' }
  it { should contain 'IPADDR="10.50.95.1"' }
  it { should contain 'NETMASK="255.255.255.0"' }
  it { should contain 'ONBOOT="yes"'}
end

#eth1 test
#IPADDR を編集してください
describe file('/etc/sysconfig/network-scripts/ifcfg-eth1') do
  it { should be_file }
  it { should contain 'DEVICE="eth1"' }
  it { should contain 'BOOTPROTO="static"' }
  it { should contain 'IPADDR="10.20.34.102"' }
  it { should contain 'NETMASK="255.255.255.0"' }
  it { should contain 'ONBOOT="yes"' }
end

#ivp6 disable test
describe command('ifconfig eth0') do
  it { should_not return_exit_status 1 }
  it { should_not return_stdout /.*inet6 addr.*/ }
end

describe command('ifconfig eth1') do
  it { should_not return_exit_status 1 }
  it { should_not return_stdout /.*inet6 addr.*/ }
end

#default_gateway test
#アドレスとインターフェースを編集してください
describe default_gateway do
  its(:ipaddress) { should eq '10.50.95.244' }
  its(:interface) { should eq 'eth0'}
end

#static_route check
#static route を追加した場合は、コメントアウトを外して
#内容を記述してください
#共有ストレージを使用する場合はコメントアウトを外すだけで良いです。
#describe routing_table do
#  it do
#    should have_entry(
#      :destination => '10.1.76.0/24',
#      :interface   => 'eth1'
#    )
#  end
#end

#ping check
#default_gateway
#アドレスを編集してください
describe host('10.50.95.244') do
  it { should be_reachable }
end

#service enable test
describe service('rhev-agentd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end
