require 'spec_helper'

#ipv6 stop setting test
describe file('/etc/sysconfig/network') do
  it { should be_file }
  it { should contain "NETWORKING_IPV6=no"}
end

describe file('/etc/sysctl.conf') do
  it { should be_file }
  it { should contain "net.ipv6.conf.all.disable_ipv6=1" }
end

#/var/log/messages test
describe file('/var/log/messages') do
  it { should_not contain "error"}
  it { should_not contain  "fail"}
end

#dmesg test
describe command('dmesg | grep -i error') do
  it { should return_exit_status 1 }
end

describe command('dmesg | grep -i fail') do
  it { should return_exit_status 1 }
end

#selinux disabled
describe selinux do
  it { should be_disabled }
end

#port 22 ssh open test
describe port(22) do
  it { should be_listening }
end

#snmpd.conf option test
describe file('/etc/sysconfig/snmpd') do
  it { should be_file }
  it { should contain 'OPTIONS="-LS 5 d -Lf /dev/null -p /var/run/snmpd.pid -a"'}
end

#yum.conf test
describe command('grep exclude /etc/yum.conf') do
  it { should return_stdout 'exclude=kernel* NetworkManager*'}
end

#inittab test
describe file('/etc/inittab') do
  it { should be_file }
  it { should contain "id:3:initdefault:"}
end

# Ctrl+ALT+Delete stop setting
describe file('/etc/init/control-alt-delete.conf') do
  it { should be_file }
  it { should contain "start on control-alt-delete" }
  it { should contain 'exec /usr/bin/logger "CTRL-ALT-DELETE trap is disabled"' }
end

#sysctl.conf test
describe file('/etc/sysctl.conf') do
  it { should be_file }
  it { should contain "kernel.sysrq = 1"}
end

#chkconfig --list number test
describe command('chkconfig --list | wc -l') do
  it { should return_stdout '56' }
end

#service enable test
describe service('abrt-ccpp') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('abrt-oops') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('abrtd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('atd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('crond') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('irqbalance') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
#  it { should be_running }
end

describe service('lvm2-monitor') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
#  it { should be_running }
end

describe service('mcelogd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('netfs') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('network') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('nfslock') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('ntpd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('ntpdate') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('portreserve') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('postfix') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('psacct') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('rpcbind') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('rpcgssd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
#  it { should be_running }
end

describe service('rpcidmapd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('snmpd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('sshd') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('sysstat') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('udev-post') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

#service disable test
describe service('NetworkManager') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('acpid') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('auditd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('autofs') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('certmonger') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('cgconfig') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('cgred') do
  it { should_not be_enabled }
  it { should_not be_running }
end

#describe service('cpuspeed') do
#  it { should_not be_enabled }
#  it { should_not be_running }
#end

describe service('cups') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('haldaemon') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('ip6tables') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('iptables') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('kdump') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('mdmonitor') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('messagebus') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('netconsole') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('nfs') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('numad') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('oddjobd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('quota_nld') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('rdisc') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('restorecond') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('rngd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('rpcsvcgssd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('saslauthd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('smartd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('snmptrapd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('sssd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('svnserve') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('ypbind') do
  it { should_not be_enabled }
  it { should_not be_running }
end
