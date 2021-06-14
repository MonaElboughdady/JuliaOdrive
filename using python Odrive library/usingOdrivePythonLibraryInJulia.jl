
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
odrv0.axis0.requested_state = py"AXIS_STATE_FULL_CALIBRATION_SEQUENCE"

