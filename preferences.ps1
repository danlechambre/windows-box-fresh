# ---------
# Debloat
# ---------

# Set up all of our preferences

# Make scroll work like Mac OS
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device Parameters" -Name "FlipFlopWheel" -Value 1

# Restart the computer and bask in glory or weep with sorrow
Restart-Computer