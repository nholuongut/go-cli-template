package cmd

import (
	"testing"

	"github.com/golang/mock/gomock"
	"github.com/spf13/cobra"
	"github.com/stretchr/testify/assert"

	"github.com/nholuongut/go-cli/internal/client"
	"github.com/nholuongut/go-cli/internal/client/mocks"
)

func TestAdd(t *testing.T) {
	ctrl := gomock.NewController(t)
	c := mocks.NewMockInterface(ctrl)

	options := client.NumbersOptions{
		Number1: 1,
		Number2: 2,
	}

	c.EXPECT().AddNumbers(options).Return(4).Times(1)

	cmd := &cobra.Command{}
	cmd.Flags().Int("num1", 1, "")
	cmd.Flags().Int("num2", 2, "")

	err := addNumbersE(c, cmd, []string{})

	assert.NoError(t, err)
}
