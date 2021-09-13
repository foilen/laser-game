package main

import (
	"fmt"
	"log"
	"os"

	"github.com/blackjack/webcam"
)

const (
	V4L2_PIX_FMT_YUYV = 0x56595559
)

func main() {

	log.Println("Open camera /dev/video0")
	cam, err := webcam.Open("/dev/video0")
	if err != nil {
		log.Fatal(err)
	}
	defer cam.Close()

	log.Println("Set Image Format")
	_, width, height, err := cam.SetImageFormat(V4L2_PIX_FMT_YUYV, 720, 480)
	if err != nil {
		log.Fatal(err)
	}
	log.Println("width:", width, "height:", height)

	log.Println("Start Streaming")
	err = cam.StartStreaming()
	if err != nil {
		log.Fatal(err)
	}

	for {
		err = cam.WaitForFrame(1)

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
			percent := count * 100 / length / 2
			log.Println("Count", count, "percent:", percent)
		}
	}

}
