require 'spec_helper'

#hostname test
#ホスト名を編集してください
describe command('hostname') do
  it { should return_stdout 'test'}
end

#redhat-release test
#redhat-release のバージョンを編集してください
describe file('/etc/redhat-release') do
  it { should contain "Red Hat Enterprise Linux Server release 5.5 (Tikanga)" }
end

#x86 test
#32bit のときは i386
describe command('uname -a') do
  it { should return_stdout /.+i386.+/ }
end

#lang test
##日本語以外の場合は編集してください
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
  it { should return_stdout /processor.+\:.+1/ }
end

#memory test
#数字に誤差が発生するので失敗するかも
#1G 1034700 kB
#4G 4050928 kB
describe file('/proc/meminfo') do
  it { should contain "MemTotal:      4152136 kB"}
end

#HDD test
#/boot は 100M で作成しても 99M と表示される
#/ は 50G で作成しても 47G と表示される
#/ は 100G で作成しても 95G と表示される
describe command('df -h') do
  it { should return_stdout /\/dev\/vda1.+219M.+\/boot/ }
  it { should return_stdout /\/dev\/vda2.+95G.+\// }
end

#/etc/fstab check
#追記を行った場合、内容を正規表現で記述してください
describe command('cat /etc/fstab') do
  it { should return_stdout /LABEL=\/.*\/.*ext3.+defaults.*1.*1/ }
  it { should return_stdout /LABEL=\/boot.*\/boot.*ext3.+defaults.*1.*2/ }
  it { should return_stdout /tmpfs.*\/dev\/shm.*tmpfs.*defaults.*0.*0/ }
  it { should return_stdout /devpts.*\/dev\/pts.*devpts.*gid=5,mode=620.*0.*0/ }
  it { should return_stdout /sysfs.*\/sys.*sysfs.*defaults.*0.*0/ }
  it { should return_stdout /proc.*\/proc.*proc.*defaults.*0.*0/ }
  it { should return_stdout /LABEL=SWAP\-vda3.*swap.*swap.*defaults.*0.*0/ }
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
