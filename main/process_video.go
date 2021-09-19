package main

import (
	"fmt"
	"log"
	"os"

	"github.com/blackjack/webcam"
)

func processVideo(cam *webcam.Webcam, diffEventChannel chan int, triggerPercent int) {

	var movingAverage = 0
	for {

		// Get next image
		err := cam.WaitForFrame(10)

		switch err.(type) {
		case nil:
		case *webcam.Timeout:
			fmt.Fprint(os.Stderr, err.Error())
			continue
		default:
			log.Fatal(err)
		}

		frame, err := cam.ReadFrame()
		if err != nil {
			log.Fatal(err)
		}
		if len(frame) != 0 {
			// Process frame
			length := len(frame) / 4
			var count = 0
			for i := 0; i < length; i++ {
				ii := i * 4
				if frame[ii] > 128 {
					count++
				}
				if frame[ii+2] > 128 {
					count++
				}
			}

			// Update the moving average
			movingAverage = (movingAverage*10 + count) / 11
			if movingAverage == 0 {
				movingAverage = 1
			}

			//  Compare to the moving average
			var diff = count - movingAverage
			if diff < 0 {
				diff *= -1
			}
			diffPercent := diff * 100 / movingAverage

			if diffPercent >= triggerPercent {
				diffEventChannel <- diffPercent
			}

		}
	}

}
