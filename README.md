## Precomputed 3D Detections
The precomputed 3D detections were computed on the Argoverse dataset using the method described in [Class-balanced Grouping and Sampling for Point Cloud 3D Object Detection](https://arxiv.org/abs/1908.09492), with detection range increased to 100 meters in each direction and pruned to ROI to match Argoverse annotation policy.

## Argoverse_cbgs_kf_tracker
This code extends [argoverse_cbgs_kf_tracker](https://github.com/johnwlambert/argoverse_cbgs_kf_tracker)

## Kalman Filter Tracking
This code extends [AB3DMOT](https://github.com/xinshuoweng/AB3DMOT), subject to its [license](https://github.com/xinshuoweng/AB3DMOT/blob/master/LICENSE). However, instead of tracking in the camera coordinate frame (as AB3DMOT does), we perform tracking in the Argoverse city coordinate frame [(see Argoverse paper and appendix)](https://arxiv.org/abs/1911.02620).

Instead of greedily matching sporadic detections, we solve a number of independent estimation problems (filtering) in a factor graph. Specifically, we use the IoU metric to perform data association (decoupling the estimation problems), and then consider each 3D detection as a measurement of an unknown state for a particular vehicle.


## Running the Code

First, install the `argoverse-api` module from [here](https://github.com/argoai/argoverse-api). Also download the data (egovehicle poses will be necessary),

Next, download the detections [zip file](https://s3.amazonaws.com/argoai-argoverse/detections_v1.1b.zip), unzip them. 

To run the tracker, pass the path to the unzipped detections directory, which should end in `argoverse_detections_2020`, to `run_ab3dmot.py`, as shown below:

```
./ run.bash
```

## Brief Explanation of Repo Contents

- `ab3dmot.py`: kalman filter state management (modified from [original](https://github.com/xinshuoweng/AB3DMOT))
- `detections_README.md`: explanation of how detections are provided
- `iou_utils.py`: simple intersection-over-union utilities
- `run_ab3dmot.py`: execute the tracker on 3d detections which must be provided in egovehicle frame
- `transform_utils.py`: upgrade SE(2) poses to SE(3) and vice versa

- `tests`
    - `test_iou_utils.py`: a few unit tests
- `visualization` (can be ignored): patches on argoverse-api for better visualization/easier eval
    - `cuboids_to_bboxes.py`: improved script for visualizing tracks (original is in argoverse-api)
    - `object_label_record.py`: updated classes to support visualizing tracks (original is in argoverse-api)
    - `eval_tracking.py`: slightly more user-friendly interface for evaluation script
    - `dump_to_argoverse.py`: Lift SE(2) detections (e.g. PointPillars) to SE(3)


## License

This code is provided by myself for purely non-commercial, research purposes. It may not be used commercially in a product without my permission.
