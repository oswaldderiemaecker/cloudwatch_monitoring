require 'serverspec'

set :backend, :exec

describe file('/etc/cron.d/cloudwatch_monitoring') do
  it { should contain '*/5 * * * * cw_monitoring /home/cw_monitoring/aws-scripts-mon-v1.1.0/mon-put-instance-data.pl --from-cron --disk-space-util --disk-path=/ --disk-space-used --disk-space-avail --swap-util --swap-used --mem-util --mem-used --mem-avail --aws-credential-file /home/cw_monitoring/aws-scripts-mon-v1.1.0/awscreds.conf || logger -t aws-scripts-mon "status=failed exit_code=$?"' }
end

describe command('/home/cw_monitoring/aws-scripts-mon-v1.1.0/mon-put-instance-data.pl --help') do
  its(:exit_status) { should eq 0 }
end
