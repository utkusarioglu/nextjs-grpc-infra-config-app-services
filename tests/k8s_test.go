package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/gruntwork-io/terratest/modules/logger"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

func TestK8s(t *testing.T) {
	t.Parallel()
	test_structure.RunTestStage(t, "k8s", func() {
		options := k8s.NewKubectlOptions("", "", "api")
		ingresses := k8s.ListIngresses(t, options, v1.ListOptions{})
		for _, ingress := range ingresses {
			logger.Log(t, ingress.Status.String())
		}
	})
}
