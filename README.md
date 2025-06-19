# Godot 4.3/4.4 vs. Godot 4.5 label performance tests

**Issue > Label Shadow Performance Problem:**
https://github.com/godotengine/godot/issues/103464

**PR (Merged) > Fix text shadow outline draw batching:**
https://github.com/godotengine/godot/pull/103471

**My System Info:**
Windows 11 (build 26100) - Multi-window, 2 monitors -  NVIDIA GeForce RTX 3050 (NVIDIA; 32.0.15.7652) - AMD Ryzen 5 5500 (12 threads) - 31.79 GiB memory 

## YouTube Video

Best to see the video of this performance test in action at: https://youtu.be/QzeClGfwYuE

## Test methodology

Will test both `Compatibility` and `Forward+` renderers.

Three + 1 test modes (outline test added post YouTube video):
- draw 1000 Labels. (No Shadows)
- draw 1000 Labels another 1000 labels as shadows, to fake shadows. (Fake Shadows)
- Use built in Godot Label shadow capabilities to draw 1000 Lables. (DEFAULT Godot Label with Shadows)
- Use built in Godot Label shadow AND outline capabilities to draw 1000 Lables. (DEFAULT Godot Label with Shadows and Outline)

## Compatibility Renderer test results

![p2](https://github.com/user-attachments/assets/d54cd7ea-922c-4925-ae12-b0cdf74c4447)

## Forward+ Renderer test results

![p1](https://github.com/user-attachments/assets/8d53ce40-f419-42e2-9efa-6a179e1177a8)

## Screen Capture

Godot 4.4.1 using `Compatibility` Renderer, drawing 1000 Labels with shadows: `21 fps`, `15789` draw calls!

![p3](https://github.com/user-attachments/assets/82624bab-de08-4729-a1f6-96123fef924a)
