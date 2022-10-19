package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/k8s"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

var namespaces = []string{
	"api",
	"ms",
	"observability",
	"cert-manager",
}

var services = []string{
	"api",
	"ms",
}

func TestK8s(t *testing.T) {
	t.Parallel()

	test_structure.RunTestStage(t, "K8s_namespaces", func() {
		t.Run("group", func(t *testing.T) {
			for _, namespace := range namespaces {
				namespace := namespace
				t.Run(namespace, func(t *testing.T) {
					t.Parallel()
					namespaceObject := k8s.GetNamespace(t, &k8s.KubectlOptions{}, namespace)
					assert.Equal(t, namespace, namespaceObject.ObjectMeta.Name)
				})
			}
		})
	})

	test_structure.RunTestStage(t, "K8s_services", func() {
		t.Run("group", func(t *testing.T) {
			for _, service := range services {
				service := service
				t.Run(service, func(t *testing.T) {
					t.Parallel()
					serviceObject := k8s.GetNamespace(t, &k8s.KubectlOptions{}, service)
					assert.Equal(t, service, serviceObject.ObjectMeta.Name)
				})
			}
		})
	})
}
