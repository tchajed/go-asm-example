package floor

import (
	"math"
	"testing"
)

func TestFloor(t *testing.T) {
	for _, tc := range []float64{
		0.1,
		1.0,
		1.1,
		1e13 + 0.3,
		0.5,
	} {
		actual := Floor(tc)
		expected := math.Floor(tc)
		if actual != expected {
			t.Errorf("%f != %f", actual, expected)
		}
	}
}
