#Do not forget to add PyCall package first
ENV["PYTHON"] = raw"E:\anaconda3\python.exe" # This switches from julia specific python to the required python version for windows, for linux use ENV["PYTHON"] = "\usr\bin\python3.6" 
import Pkg
Pkg.build("PyCall") #You do not need to run lines 1 to 4 every time you want to deal with the odrive
using PyCall
odrive = pyimport("odrive")
odrv0 = odrive.find_any() 
print(odrv0.vbus_voltage)
#in order to be able to use the enums and utils similar to the odrivetool
py"""
from odrive.enums import * 
"""
py"""
from odrive.utils import *
"""
odrv0.axis0.requested_state = py"AXIS_STATE_CLOSED_LOOP_CONTROL" #closed loop control mode
#make the motor follows a sinusoidal trajectory
for i=1:500
    odrv0.axis0.controller.input_pos = sin(i*0.13)*0.3
    sleep(0.01)
end
# dump the errors in odrive (to dump and clear errors use odrive.utils.dump_errors(odrv0,true)), note that the typeof it is "Nothing" 
print(odrive.utils.dump_errors(odrv0))
