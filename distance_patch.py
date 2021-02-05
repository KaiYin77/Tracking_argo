import numpy as np

Dis_list = []
dis = math.sqrt( (sdc_xyz[0]-bbox3D[0])*(sdc_xyz[0]-bbox3D[0]) + (sdc_xyz[1]-bbox3D[1])*(sdc_xyz[1]-bbox3D[1]) )
Dis_list.append(dis) 
DIS_Threshold = np.percentile(Dis_list, 75)
print(DIS_Threshold)

if dis > __DIS_Threshold__:
   self.kf.R[:2, :2] *= 1.5 
