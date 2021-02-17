
## Argoverse_cbgs_kf_tracker
This code extends [argoverse_cbgs_kf_tracker](https://github.com/johnwlambert/argoverse_cbgs_kf_tracker)

## Kalman Filter Tracking
This code extends [AB3DMOT](https://github.com/xinshuoweng/AB3DMOT), subject to its [license](https://github.com/xinshuoweng/AB3DMOT/blob/master/LICENSE). However, instead of tracking in the camera coordinate frame (as AB3DMOT does), we perform tracking in the Argoverse city coordinate frame [(see Argoverse paper and appendix)](https://arxiv.org/abs/1911.02620).

Instead of greedily matching sporadic detections, we solve a number of independent estimation problems (filtering) in a factor graph. Specifically, we use the IoU metric to perform data association (decoupling the estimation problems), and then consider each 3D detection as a measurement of an unknown state for a particular vehicle.


## Running the Code

```
./ run.bash
```

## what I've Done
1.  一開始用Baseline code看Rviz時可以發現到detection的物體分成兩種，行人跟車，車子的部分又只有小型房車而已，其他如大客車、公車只有Lidar points的紋路，官方的Detection是沒有Detect到的，所以這類型的是沒辦法 Tracking的。這階段我還沒能力重新Train Model 把官方處理不好的Detection的部分重新處理，所以這次只針對Tracking的部分來嘗試跟發想。

(發現Detection有提供類別的資訊，但Baseline code並沒有納入考慮，所以我就將他include到code裡面)

2.  Watching the Rviz , I found that far away the SDC, the detection data is too bad to get a good tracking result, the car or pedestrian 3Dbox are rotating and emerge on again,  it’s not very stable. 

將SDC從ego frame轉到city frame算出車子的位子丟到主程式裡，有了這個參數我就可以算距離了，dis是SDC到track_object的距離，我的想法是dis越大的，measurement error 會越大，所以我希望他的measurement matrix能動態的調整。

3.  查到不同的data assoiciation function，都是Hungarian algorithm，但output的data type不一樣要轉換一下，我發現結果其實差不多，沒有顯著的變化。


4.  一開始的想法是車子跟行人的行為模式差很多，在data associate上應該要分開討論，所以想怎麼讓兩者的最簡的行為模式考慮進去，我就嘗試了下面的方法。
![image](picture or gif url)

這邊的想法是，因為原算法是將Detection的3DBOX投影成2D的矩形，第一個想法是人跟車的移動行為非常不一樣，利用剛剛傳進來的Classname將人跟車分開處理，人的移動比較隨機，所以想說讓人在IOU的threshold小一點，這樣他比較不會把同一個人視為不同的人。我發現這個結果相對好很多，Tracking的accuracy指標有提升，id_switching次數也有下降，但precision結果下降。這樣的結果我覺得非常合理，threshold調降error上升。

此外，有個想法是因為data associate的方法，是將detection 3DBox 投影到地面2D形狀來做data association的，但人跟車的移動速度相差很大，形狀也不一樣，現在還沒想清楚他會怎麼影響結果。
