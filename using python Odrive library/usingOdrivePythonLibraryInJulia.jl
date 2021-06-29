
ENV["PYTHON"] = raw"E:\anaconda3\python.exe" 
import Pkg
Pkg.build("PyCall")
using PyCall
odrive = pyimport("odrive")
odrv0 = odrive.find_any()
print(odrv0.vbus_voltage)
py"""
from odrive.enums import * 
"""
py"""
from odrive.utils import *
"""
odrv0.axis0.requested_state = py"AXIS_STATE_CLOSED_LOOP_CONTROL"
for i=1:500
    odrv0.axis0.controller.input_pos = sin(i*0.13)*0.3
    sleep(0.01)
end

print(odrive.utils.dump_errors(odrv0))