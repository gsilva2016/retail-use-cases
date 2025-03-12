from transformers import AutoProcessor, AutoModelForImageTextToText
import torch
import time
import os
from typing import List, Optional
from decord import VideoReader, cpu
from langchain.llms.base import LLM

class SmolVLM2Wrapper(LLM):
    processor: object
    model: object
    device: str
    max_new_tokens: int        
    
    @property
    def _llm_type(self) -> str:
        return "Custom SmolVLM2"
        
    def _call(
        self,
        prompt: str,
        stop: Optional[List[str]] = None,
    ) -> str:

        # Parse prompt str(VIDEO_PATH, PROMPT)
        video_fh, question = prompt.split(',', 1)

        # Process text only
        if video_fh == '':
            messages = [
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": question}
                    ]
                },
            ]

            inputs = self.processor.apply_chat_template(
                messages,
                add_generation_prompt=True,
                tokenize=True,
                return_dict=True,
                return_tensors="pt").to(self.device, dtype=torch.bfloat16)
            print("Processed text-only inputs")

            generated_ids = self.model.generate(**inputs, do_sample=False, max_new_tokens=self.max_new_tokens)
            generated_texts = self.processor.batch_decode(generated_ids, skip_special_tokens=True)[0]

        # Process video and text
        else:
            messages = [
                {
                    "role": "user",
                    "content": [
                        {"type": "video", "video": video_fh},
                        {"type": "text", "text": question}
                    ]
                },
            ]

            inputs = self.processor.apply_chat_template(
                messages,
                add_generation_prompt=True,
                tokenize=True,
                return_dict=True,
                return_tensors="pt").to(self.device, dtype=torch.bfloat16)
            print("Processed visual and text inputs")

            generated_ids = self.model.generate(**inputs, do_sample=False, max_new_tokens=self.max_new_tokens)
            generated_texts = self.processor.batch_decode(generated_ids, skip_special_tokens=True)[0]

        print(generated_texts)    
        return str(generated_texts)

def SmolVLM2Worker(model_dir: str,
                       device: str,
                       max_new_tokens: int) -> object:
    
    # LOAD smolvlm2 TOKENIZER AND MODEL HERE AND PASS IN THESE TO OVMINICPMWRAPPER
    processor = AutoProcessor.from_pretrained(model_dir)
    model = AutoModelForImageTextToText.from_pretrained(model_dir, torch_dtype=torch.bfloat16).to(device)
    print("SmolVLM2 loaded!")

    # LOAD TOKENIZER AND MODEL HERE AND PASS IN THESE TO OVMINICPMWRAPPER
    # Wrap for langchain integration
    smolvlm2_wrapper = SmolVLM2Wrapper(processor=processor, model=model, device=device, max_new_tokens=max_new_tokens)
    return smolvlm2_wrapper
