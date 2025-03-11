---
title: YOLOv8预训练模型的使用
pin: false
---

环境配置什么的都不写了，简单记录一下[YOLOv8](https://yolov8.com)的用途。

## 目标检测 Object Detection

看看[这个](https://colab.research.google.com/drive/1XJmFLZ5Egsd-miQM9yGInNvS39JsEHEm?usp=share_link)代码文件吧。

检测多张图片的时候还是用命令行比较方便:

```bash
yolo predict model=yolov8n.pt source="/images" conf=0.5 save=True project="/images"
```

这里用的是最小的`yolov8n.pt`模型，初次运行会把模型下载到当前目录下。

不指定`project`时默认会保存检测结果到`./run/predict`文件夹。

对视频进行目标检测的话改一下上面命令的`source`参数就行。

实时目标检测可以参照下面的代码：

```python
import cv2
from ultralytics import YOLO

model = YOLO("yolov8n.pt")

# 打开摄像头
# 0表示电脑内建摄像头，其他数字可表示外接摄像头
cap = cv2.VideoCapture(0)

# 设置视频窗口
while cap.isOpened():
    ret, frame = cap.read()
    
    if not ret:
        print("无法读取视频流！")
        break
    
    # 对视频帧进行目标检测
    results = model(frame)
    
    # 提取检测结果并绘制边界框
    for result in results:
        frame = result.plot()
    
    # 显示检测结果
    cv2.imshow("YOLOv8 实时目标检测", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# 释放摄像头和关闭所有OpenCV窗口
cap.release()
cv2.destroyAllWindows()

```

我用的是mac加iPhone，运行上面代码后使用的是iPhone的摄像头，举着手机到处拍就可以进行实时目标检测了。


## 目标跟踪 Object Tracking

对视频文件做目标跟踪：`yolo task=detect mode=track model=yolov8n.pt source=video.mp4 conf=0.5 iou=0.5 show=True save=True`

## 图像分割 Instance Segmentation

yolo task=segment mode=predict model=yolov8n-seg.pt source=imgs

## 实时运动检测 Motion Detection

```python
import cv2
import torch
from ultralytics import YOLO

# 加载 YOLOv8 预训练模型
model = YOLO("yolov8n.pt")  # 目标检测模型
# model = YOLO("yolov8n-seg.pt")  # 若要进行实例分割，可切换到分割模型

# 读取摄像头
cap = cv2.VideoCapture(0)  # 0 表示默认摄像头

prev_objects = {}  # 记录上一帧的目标位置

while cap.isOpened():
    success, frame = cap.read()
    if not success:
        break  # 若无法读取帧，则退出循环

    # YOLOv8 目标检测
    results = model(frame)

    current_objects = {}  # 记录当前帧目标位置
    frame_with_boxes = frame.copy()

    for result in results:
        boxes = result.boxes.xyxy  # 获取边界框坐标
        classes = result.boxes.cls  # 获取类别索引
        confidences = result.boxes.conf  # 获取置信度

        for box, cls, conf in zip(boxes, classes, confidences):
            x1, y1, x2, y2 = map(int, box)
            label = f"{model.names[int(cls)]} {conf:.2f}"

            # 记录当前帧的目标位置
            current_objects[label] = (x1, y1, x2, y2)

            # 绘制边界框
            color = (0, 255, 0)  # 绿色
            cv2.rectangle(frame_with_boxes, (x1, y1), (x2, y2), color, 2)
            cv2.putText(frame_with_boxes, label, (x1, y1 - 10),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)

            # 检测运动（比较前后帧的目标位置变化）
            if label in prev_objects:
                x1_prev, y1_prev, x2_prev, y2_prev = prev_objects[label]
                movement = abs(x1 - x1_prev) + abs(y1 - y1_prev) + abs(x2 - x2_prev) + abs(y2 - y2_prev)
                
                # 如果位移超过阈值，则认为目标在运动
                if movement > 30:  
                    cv2.putText(frame_with_boxes, "Moving!", (x1, y1 - 30),
                                cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 3)

    prev_objects = current_objects  # 更新上一帧数据

    cv2.imshow("YOLOv8 Live Motion Detection", frame_with_boxes)

    # 按 'q' 键退出
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()
```

## 其他

- 自定义目标检测 Custome Object Detection

- 类别识别于分类 Class Recognition & Classification

- 异常检测 Anomaly Detection

- 模型推理 Model Inference

上面这些都是大模型给列出的用途，不展开了。后面去试试自己训练模型。
