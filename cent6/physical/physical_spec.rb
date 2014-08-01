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
#redhat-release のバージョンを編集してください
describe file('/etc/redhat-release') do
  it { should contain "CentOS release 6.4" }
end

#x86 test
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
describe file('/proc/meminfo') do
  it { should contain "MemTotal:        1020820 kB"}
end

#HDD test
#/boot は 250M で作成しても 243M と表示される
#/ は 50G で作成しても 48G と表示される
describe command('df -h') do
  it { should return_stdout /\/dev\/vda1.+243M.+\/boot/ }
  it { should return_stdout /\/dev\/vda3.+48G.+\// }
end

#/etc/fstab check
#追記を行った場合、内容を正規表現で記述してください
describe command('cat /etc/fstab') do
  it { should return_stdout /.*\/.*ext4.+defaults.*1.*1/ }
  it { should return_stdout /.*\/boot.*ext4.+defaults.*1.*2/ }
  it { should return_stdout /.*swap.*swap.*defaults.*0.*0/ }
  it { should return_stdout /tmpfs.*\/dev\/shm.*tmpfs.*defaults.*0.*0/ }
  it { should return_stdout /devpts.*\/dev\/pts.*devpts.*gid=5,mode=620.*0.*0/ }
  it { should return_stdout /sysfs.*\/sys.*sysfs.*defaults.*0.*0/ }
  it { should return_stdout /proc.*\/proc.*proc.*defaults.*0.*0/ }
end

#bond0 test
#設定を行った内容に書き換えてください
describe file('/etc/sysconfig/network-scripts/ifcfg-bond0') do
  it { should be_file }
  it { should contain 'DEVICE=bond0' }
  it { should contain 'BOOTPROTO=static' }
  it { should contain 'IPADDR=10.0.38.30' }
  it { should contain 'NETMASK=255.255.255.0' }
  it { should contain 'ONBOOT="yes"'}
  it { should contain 'TYPE=bonding'}
  it { should contain 'BONDING_OPTS="mode=1 primary=em1 miimon=100 updelay=5000"'}
end

#em1 test
#設定を行った内容に書き換えてください
describe file('/etc/sysconfig/network-scripts/ifcfg-em1') do
  it { should be_file }
  it { should contain 'DEVICE=em1' }
  it { should contain 'BOOTPROTO=none' }
  it { should contain 'ONBOOT=yes' }
  it { should contain 'MASTER=bond0' }
  it { should contain 'SLAVE=yes' }
  it { should contain 'ETHTOOL_OPTS="autoneg off speed 100 duplex full"' }
end

#em2 test
#設定を行った内容に書き換えてください
describe file('/etc/sysconfig/network-scripts/ifcfg-em2') do
  it { should be_file }
  it { should contain 'DEVICE=em2' }
  it { should contain 'BOOTPROTO=none' }
  it { should contain 'ONBOOT=yes' }
  it { should contain 'MASTER=bond0' }
  it { should contain 'SLAVE=yes' }
  it { should contain 'ETHTOOL_OPTS="autoneg off speed 100 duplex full"' }
end

#ivp6 disable test
#使用するインターフェースの数に合わせて増減させてください
describe command('ifconfig em1') do
  it { should_not return_exit_status 1 }
  it { should_not return_stdout /.*inet6 addr.*/ }
end

describe command('ifconfig em2') do
  it { should_not return_exit_status 1 }
  it { should_not return_stdout /.*inet6 addr.*/ }
end

#default_gateway test
#アドレスとインターフェースを編集してください
describe default_gateway do
  its(:ipaddress) { should eq '10.50.95.244' }
  its(:interface) { should eq 'bond0'}
end

#static_route check
#static route を追加した場合は、コメントアウトを外して
#内容を記述してください
#describe routing_table do
#  it do
#    should have_entry(
#      :destination => '10.50.0.0/24',
#      :interface   => 'eth0'
#    )
#  end
#end

#ping check
#default_gateway
#アドレスを編集してください
describe host('10.50.95.244') do
  it { should be_reachable }
end

#interface test
#インターフェースの状況に合わせて設定してください
describe command('ethtool em1 | grep Speed') do
  it { should_not return_exit_status 1 }
  it { should return_stdout /.*Speed: 100Mb\/s.*/ }
end

describe command('ethtool em1 | grep Duplex') do
  it { should return_stdout /.*Duplex: Full.*/ }
end

describe command('ethtool em2 | grep Speed') do
  it { should_not return_exit_status 1 }
  it { should return_stdout /.*Speed: 100Mb\/s.*/ }
end

describe command('ethtool em2 | grep Duplex') do
  it { should return_stdout /.*Duplex: Full.*/ }
end

#service enable test
describe service('dataeng') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('dsm_om_connsvc') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('dsm_om_shrsvc') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end
