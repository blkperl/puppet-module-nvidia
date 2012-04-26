# nvidia_graphics_device Custom Fact
#
# Computer Action Team
# Maseeh College of Engineering & Computer Science
#
# Returns a bool representing whether or not there is an nvidia graphics
# device installed on the system.

Facter.add(:nvidia_graphics_device) do
  confine :kernel => :linux
  setcode do
    vendor  = Array.new
    device  = Array.new
    fields  = /^"([^"]*)" "([^"]*)"/
    command = %q{lspci -mm | sed -n 's/^[0-9:. ]*"VGA compatible controller" //p'}
    sysinfo = Facter::Util::Resolution.exec(command)
    sysinfo.each_line do |line|
      vendor << fields.match(line)[1]
      device << fields.match(line)[2]
    end unless sysinfo.nil?
    vendor.include?('nVidia Corporation')
  end
end
