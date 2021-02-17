
## Argoverse_cbgs_kf_tracker
This code extends [argoverse_cbgs_kf_tracker](https://github.com/johnwlambert/argoverse_cbgs_kf_tracker)

## Kalman Filter Tracking
This code extends [AB3DMOT](https://github.com/xinshuoweng/AB3DMOT), subject to its [license](https://github.com/xinshuoweng/AB3DMOT/blob/master/LICENSE). However, instead of tracking in the camera coordinate frame (as AB3DMOT does), we perform tracking in the Argoverse city coordinate frame [(see Argoverse paper and appendix)](https://arxiv.org/abs/1911.02620).

Instead of greedily matching sporadic detections, we solve a number of independent estimation problems (filtering) in a factor graph. Specifically, we use the IoU metric to perform data association (decoupling the estimation problems), and then consider each 3D detection as a measurement of an unknown state for a particular vehicle.


## Running the Code

```
./ run.bash
```
