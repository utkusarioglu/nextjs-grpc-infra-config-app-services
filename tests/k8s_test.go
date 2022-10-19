package tests

import (
	"fmt"
	"regexp"
	"testing"

	"github.com/gruntwork-io/terratest/modules/k8s"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

var namespaces = []string{
	"api",
	"ms",
	"observability",
	"cert-manager",
}

var services = []string{
	"kube-dns",
	"metrics-server",
	"cert-manager",
	"cert-manager-webhook",
	"opentelemetry-operator-webhook-service",
	"opentelemetry-operator-controller-manager-metrics-service",
	"loki-headless",
	"loki-memberlist",
	"loki",
	"jaeger-jaeger-operator-metrics",
	"jaeger-collector-headless",
	"jaeger-collector",
	"jaeger-query",
	"jaeger-agent",
	"otel-trace-collector",
	"otel-trace-collector-headless",
	"otel-trace-collector-monitoring",
	"otel-log-collector-monitoring",
	"ms",
	"prometheus-server",
	"prometheus-kube-state-metrics",
	"prometheus-node-exporter",
	"grafana",
	"ethereum-storage-postgresql-hl",
	"ethereum-storage-postgresql-metrics",
	"ethereum-storage-postgresql",
	"api",
	"bunny",
}

var nodeCount int = 5

var podSpecs = []*struct {
	prefix        string
	expectedCount int
}{
	{
		prefix:        "cert-manager",
		expectedCount: 3,
	},
	{
		prefix:        "opentelemetry-operator",
		expectedCount: 1,
	},
	{
		prefix:        "otel-log-collector",
		expectedCount: nodeCount,
	},
	{
		prefix:        "prometheus-node-exporter",
		expectedCount: nodeCount,
	},
	{
		prefix:        "api",
		expectedCount: 1,
	},
	{
		prefix:        "ethereum-storage-postgresql",
		expectedCount: 1,
	},
	{
		prefix:        "grafana",
		expectedCount: 1,
	},
	{
		prefix:        "jaeger",
		expectedCount: 2,
	},
	{
		prefix:        "jaeger-jaeger-operator",
		expectedCount: 1,
	},
	{
		prefix:        "loki",
		expectedCount: 1,
	},
	{
		prefix:        "otel-log-collector",
		expectedCount: nodeCount,
	},
	{
		prefix:        "otel-trace-collector",
		expectedCount: 1,
	},
	{
		prefix:        "prometheus-node-exporter",
		expectedCount: nodeCount,
	},
	{
		prefix:        "prometheus-kube-state-metrics",
		expectedCount: 1,
	},
	{
		prefix:        "prometheus-server",
		expectedCount: 1,
	},
	{
		prefix:        "metrics-server",
		expectedCount: 1,
	},
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
					serviceObject := k8s.GetService(t, &k8s.KubectlOptions{}, service)
					assert.Equal(t, service, serviceObject.ObjectMeta.Name)
				})
			}
		})
	})

	test_structure.RunTestStage(t, "K8s_pods", func() {
		pods := k8s.ListPods(t, &k8s.KubectlOptions{}, v1.ListOptions{})
		for _, pod := range pods {
			for _, podSpec := range podSpecs {
				assert.Regexp(t, regexp.MustCompile(fmt.Sprintf("^%s", podSpec.prefix)), pod.ObjectMeta.Name)
			}
		}
	})
}
