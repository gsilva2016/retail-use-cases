#!/bin/bash

source activate-conda.sh
activate_conda
conda activate ovlangvidsumm

if [ "$1" == "--skip" ]; then
	echo "Skipping sample video download"
else
    # Download sample video
    wget https://github.com/intel-iot-devkit/sample-videos/raw/master/one-by-one-person-detection.mp4
fi

RTSP_SOURCES="rtsp://admin:<password>@192.168.2.109"

PROMPT="Describe the video in detail, specifically noting the behaviors of people within the frames."

echo "Starting FastAPI app"
uvicorn api.app:app &
APP_PID=$!
sleep 10

echo "Running Video Summarizer"
PYTHONPATH=. python summarizer/video_summarizer.py -rs "$RTSP_SOURCES" -p "$PROMPT"

# terminate fastapi app after video summarization concludes
kill $APP_PID
