#0710851_running the baseline code
DETECTIONS_DATAROOT="/home/ee904/sdc_final_data/argoverse_detections_2020"
POSE_DIR="/home/ee904/sdc_final_data/argoverse-tracking/argoverse-tracking/val"
SPLIT="val"
TRACKS_DUMP_DIR="/home/ee904/sdc_final_data/sdc_final_result/try_0710851_dis"
python3 run_ab3dmot.py --dets_dataroot $DETECTIONS_DATAROOT --pose_dir $POSE_DIR --split $SPLIT --tracks_dump_dir $TRACKS_DUMP_DIR
