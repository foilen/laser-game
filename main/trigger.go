package main

import (
	"bytes"
	"log"
	"math"
	"time"

	"github.com/hajimehoshi/oto/v2"
)

func trigger(diffEventChannel chan bool) {

	// Prepare audio
	otoContext, ready, err := oto.NewContext(44100, 1, 1)
	if err != nil {
		log.Fatal(err)
	}
	<-ready

	var sample []byte = make([]byte, 44100)
	for t := 0; t < 44100; t++ {
		freq := 440.0 + 500*float64(t)/44100
		sinPart := 2.0 * float64(math.Pi) * freq * float64(t) / 44100.0
		sample[t] = byte(math.Sin(sinPart)*128 + 128)
	}

	// wait for events
	for {
		<-diffEventChannel

		log.Println("TRIGGERED")

		// Make a sound
		p := otoContext.NewPlayer(bytes.NewReader(sample))
		p.Play()
		time.Sleep(1 * time.Second)
		p.Close()

		// Clear the channel
		for len(diffEventChannel) > 0 {
			<-diffEventChannel
		}

	}
}
