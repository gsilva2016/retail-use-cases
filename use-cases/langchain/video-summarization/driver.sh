# ###################################
# ### Video Pipeline (openvino-genai)
# ###################################

python minicpm-v-2_6_ov-langchain-video-summarization.py handwashing_10fps.avi MiniCPM_INT4/ -d "GPU" -f 10

### Example Output
# Video duration: 1:31
# Num frames sampled: 1
# The video presents a static image of a stainless steel sink with a faucet, set against a tiled floor. There is no movement or change in the scene throughout the frames provided. The sink appears to be in a kitchen or a similar setting, given the context of the tiles and the presence of what seems to be a part of a countertop on the left side. The lighting is even, suggesting an indoor environment with artificial lighting. There are no discernible background elements or additional objects that provide context beyond the sink and the floor. The video lacks any dynamic action or narrative progression, focusing solely on the depiction of the sink.
# Inference time: 6.8080644607543945 sec

# Video duration: 1:31
# Num frames sampled: 10
# The video begins with a series of still images showing a stainless steel sink with a faucet, set against a tiled background. The images are nearly identical, with the sink and faucet in the center, and the tiles providing a consistent backdrop. As the video progresses, the images transition to show hands at the sink, with the faucet turned on, indicating the start of a handwashing process. The hands are positioned under the faucet, suggesting the act of washing. The sequence of images captures the progression of handwashing, with the hands moving through various stages of the process, including lathering and rinsing. The lighting and background remain consistent throughout, focusing the viewer's attention on the handwashing activity.
# Inference time: 23.118029832839966 sec

# Video duration: 1:31
# Num frames sampled: 64
# The video begins with a static shot of a stainless steel sink set against a tiled floor, with a faucet and a drain visible. The lighting is even, suggesting an indoor setting with artificial light. As the video progresses, a pair of hands enters the frame, interacting with the faucet, indicating the start of a washing process. The hands are seen turning the faucet on and off, and then engaging in the act of washing, with water flowing and hands moving under the stream. The sequence of actions suggests a routine handwashing procedure, with the hands thoroughly rinsing and scrubbing. The background remains consistent throughout, with no changes in the environment or the camera's perspective. The video concludes with the hands still under the running water, indicating the continuation of the washing process.
# Inference time: 116.90528750419617 sec

# #########################
# ### Video Pipeline (CUDA)
# #########################

# python minicpm-v-2_6_langchain-video-summarization.py -v handwashing_10fps.avi

### Example output
# The video starts with a static image of a stainless steel sink against a patterned tile background. Shortly after, hands enter the frame and begin washing at the faucet, which is turned on. The hands are seen manipulating water to cleanse, with visible soap suds forming as they rub together and over the skin. Throughout the sequence, the focus remains on the handwashing process without any camera movement or change in perspective.

# ##################
# ### Image Pipeline
# ##################

# python minicpm-v-2_6_langchain-image-summarization.py my_image.png "What's in this image?"

### Example Output
# This image is a slide from a presentation about NVIDIA's Data Center business segment. The title, 'Data Center,' is highlighted in green at the top, with a subtitle stating 'The leading computing platform for AI, HPC & graphics.' The slide includes financial data and strategic information.

# On the left side of the slide, there's a bar chart showing revenue growth over fiscal years (FY) from FY19 to 1H FY24. The revenues are as follows:
# - FY19: $2,932 million
# - FY20: $2,983 million
# - FY21: $6,696 million
# - FY22: $10,613 million
# - FY23: $15,005 million
# - 1H FY24: $14,607 million

# The slide also notes that this segment has achieved a 51% five-year compound annual growth rate (CAGR) through FY23.

# On the right side, under the heading 'Leader in AI & HPC,' it states that NVIDIA is #1 in AI training and inference. It mentions that their technology is used by all hyperscale and major cloud computing providers and 40,000 enterprises. Furthermore, it powers 74% of the TOP500 supercomputers.

# Under 'Growth Drivers,' the slide lists several factors contributing to the growth of the Data Center segment:
# - Rapid AI adoption across industries
# - Full-stack AI | Software
# - Three chip strategy — GPU | CPU | DPU
# - Rising computation requirements for modern AI
# - Data-center scale innovation
# - Omniverse

# At the bottom right corner, the slide is branded with the NVIDIA logo, indicating the source of the information.


