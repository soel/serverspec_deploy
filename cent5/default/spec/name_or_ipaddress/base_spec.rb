require 'spec_helper'

#ipv6 stop setting test
describe file('/etc/sysconfig/network') do
  it { should be_file }
  it { should contain "NETWORKING_IPV6=no"}
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
describe file('/etc/sysconfig/snmpd.options') do
  it { should be_file }
  it { should contain 'OPTIONS="-LS 5 d -Lf /dev/null -p /var/run/snmpd.pid -a"'}
end

#yum.conf test
describe file('/etc/yum.conf') do
  it { should be_file }
  it { should contain 'exclude=kernel*'}
end

#inittab test
describe file('/etc/inittab') do
  it { should be_file }
  it { should contain "id:3:initdefault:"}
  it { should contain "si::sysinit:/etc/rc.d/rc.sysinit"}
  it { should contain "l0:0:wait:/etc/rc.d/rc 0"}
  it { should contain "l1:1:wait:/etc/rc.d/rc 1"}
  it { should contain "l2:2:wait:/etc/rc.d/rc 2"}
  it { should contain "l3:3:wait:/etc/rc.d/rc 3"}
  it { should contain "l4:4:wait:/etc/rc.d/rc 4"}
  it { should contain "l5:5:wait:/etc/rc.d/rc 5"}
  it { should contain "l6:6:wait:/etc/rc.d/rc 6"}
  it { should contain 'pf::powerfail:/sbin/shutdown -f -h +2 "Power Failure; System Shutting Down"'}
  it { should contain 'pr:12345:powerokwait:/sbin/shutdown -c "Power Restored; Shutdown Cancelled"'}
  it { should contain "1:2345:respawn:/sbin/mingetty tty1"}
  it { should contain "2:2345:respawn:/sbin/mingetty tty2"}
  it { should contain "3:2345:respawn:/sbin/mingetty tty3"}
  it { should contain "x:5:respawn:/etc/X11/prefdm -nodaemon"}
end

#sysctl.conf test
describe file('/etc/sysctl.conf') do
  it { should be_file }
  it { should contain "kernel.sysrq = 1"}
end

#service enable test
describe service('anacron') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
#  it { should be_running }
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

describe service('firstboot') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
#  it { should be_running }
end

describe service('irqbalance') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('kudzu') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
  it { should be_running }
end

describe service('lvm2-monitor') do
  it { should be_enabled }
  it { should be_enabled.with_level(3) }
  it { should be_enabled.with_level(5) }
#  it { should be_running }
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

describe service('portmap') do
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

describe service('sendmail') do
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

describe service('syslog') do
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

describe service('avahi-daemon') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('avahi-dnsconfd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('bluetooth') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('conman') do
  it { should_not be_enabled }
  it { should_not be_running }
end

#describe service('cpuspeed') do
#  it { should_not be_enabled }
#  it { should_not be_running }
#end

describe service('dnsmasq') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('dund') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('gpm') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('haldaemon') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('hidd') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('ip6tables') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('ipmi') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('ipmievd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('iptables') do
  it { should_not be_enabled }
#  it { should_not be_running }
# fabric で手順化したら有効化する  
end

describe service('irda') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('iscsi') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('iscsid') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('lm_sensors') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('mcstrans') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('mdmonitor') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('mdmpd') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('messagebus') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('microcode_ctl') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('multipathd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('netconsole') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('netplugd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('nfs') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('nscd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('oddjobd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('pand') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('pcscd') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('rawdevices') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('rdisc') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('readahead_early') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('readahead_later') do
  it { should_not be_enabled }
#  it { should_not be_running }
end

describe service('restorecond') do
  it { should_not be_enabled }
#  it { should_not be_running }
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

describe service('svnserve') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('winbind') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('wpa_supplicant') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('xfs') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('ypbind') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('yum-updatesd') do
  it { should_not be_enabled }
  it { should_not be_running }
end
