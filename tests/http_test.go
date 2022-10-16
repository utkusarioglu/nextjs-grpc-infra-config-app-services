package tests

import (
	"crypto/tls"
	"strings"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestHttp(t *testing.T) {
	t.Parallel()

	testCases := []*struct {
		name     string
		url      string
		expected string
	}{
		{
			name:     "grpc",
			url:      "https://nextjs-grpc.utkusarioglu.com/grpc",
			expected: "Your name is utku, you are 3 years old, you are a teacher",
		},
		{
			name:     "home",
			url:      "https://nextjs-grpc.utkusarioglu.com",
			expected: "rocket",
		},
		{
			name:     "Grafana",
			url:      "https://grafana.nextjs-grpc.utkusarioglu.com/login",
			expected: "Grafana Labs",
		},
		{
			name:     "Jaeger",
			url:      "https://jaeger.nextjs-grpc.utkusarioglu.com/search",
			expected: "Jaeger UI",
		},
	}

	test_structure.RunTestStage(t, "http_app", func() {
		t.Run("group", func(t *testing.T) {
			for _, testCase := range testCases {
				testCase := testCase
				t.Run(testCase.name, func(t *testing.T) {
					t.Parallel()
					validateResponse := func(status_code int, response_text string) bool {
						return strings.Contains(response_text, testCase.expected)
					}

					tls_config := &tls.Config{
						InsecureSkipVerify: true,
					}

					http_helper.HttpGetWithRetryWithCustomValidation(
						t,
						testCase.url,
						tls_config,
						10,
						10*time.Second,
						validateResponse,
					)
				})
			}
		})
	})
}
