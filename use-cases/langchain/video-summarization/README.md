# Summarize Videos Using OpenVINO-GenAI, Langchain, and MiniCPM-V-2_6

## Installation

1. First, follow the steps on the [MiniCPM-V-2_6 HuggingFace Page](https://huggingface.co/openbmb/MiniCPM-V-2_6) to gain
access to the model. For more information on user access tokens for access to gated models
see [here](https://huggingface.co/docs/hub/en/security-tokens).
2. Next, install Intel Client GPU, Conda, Set Up Python Environment and Create OpenVINO optimized model for MiniCPM

```
# Validated on Ubuntu 24.04 and 22.04
./install.sh
```

Note: if this script has already been performed and you'd like to re-install the sample project only, the following
command can be used to skip the re-install of dependencies. 

```
./install.sh --skip
```

## Install HF Transformers package that enables smolvlm2 inference from source
```
pip install git+https://github.com/huggingface/transformers@v4.49.0-SmolVLM-2
```

## Run Video Summarization

Summarize [this sample video](https://github.com/intel-iot-devkit/sample-videos/raw/master/one-by-one-person-detection.mp4)
using `video_summarizer.py`.

```
./run-demo.sh 
```

Note: if the demo has already been run, you can use the following command to skip the video download.

```
./run-demo.sh --skip
```
