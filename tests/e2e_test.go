package tests

import (
	"testing"

	shell "github.com/gruntwork-io/terratest/modules/shell"
)

func TestE2e(t *testing.T) {
	t.Parallel()
	t.Run("e2e", func(t *testing.T) {
		shell.RunCommand(t, shell.Command{
			WorkingDir: "/utkusarioglu-com/projects/nextjs-grpc/e2e",
			Command:    "scripts/docker-run-cypress.sh",
		})
	})
}
