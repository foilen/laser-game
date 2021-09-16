package main

import (
	"log"
	"sync"

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

	// Start the channel
	diffEventChannel := make(chan bool, 100)

	var wg sync.WaitGroup
	wg.Add(1)
	go processVideo(cam, diffEventChannel)
	go trigger(diffEventChannel)
	wg.Wait()

}
