package api

import "regexp"

const (
	BootstrapTokenForm = `\A([a-z0-9]{6})\.([a-z0-9]{16})\z`
	CertForm           = `\A([a-z0-9]{64})\z`
)

func ValidateCert(cert string) bool {
	re, _ := regexp.Compile(common.CertForm)
	substrs := re.FindStringSubmatch(cert)
	if len(substrs) != 2 {
		klog.Errorf("The cert %q was not of the form %q", cert, CertForm)
		return false
	}

	return true
}

func ValidateBootStrapToken(token string) bool {
	// Note: this token should not contain string "sha256:"
	re, _ := regexp.Compile(BootStrapTokenForm)
	substrs := re.FindStringSubmatch(token)
	if len(substrs) != 3 {
		klog.Warningf("The bootstrap token %q was not of the form %q", token, BootStrapTokenForm)
		return false
	}

	return true
}
