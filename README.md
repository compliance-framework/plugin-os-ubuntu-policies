# plugin-os-ubuntu-policies

## Testing


```shell
opa test policies
```

## Bundling

Policies are built into bundle to make distribution easier. 

You can easily build the policies by running 
```shell
make build
```

## Running policies locally

```shell
opa eval -I -b policies -f pretty data.security <<EOF 
[
  {
    "title": "Vulnerability CVE-2020-5311 detected",
    "description": "libImaging/SgiRleDecode.c in Pillow before 6.2.2 has an SGI buffer overflow.",
    "severity": "HIGH",
    "remarks": "Review and apply patches to address this vulnerability.",
    "cve_id": "CVE-2020-5311"
  }
]
EOF
```

## Writing policies.

Policies are written in the [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) language.

```rego
package ssh.deny_password_auth

import future.keywords.in

violation[{
    "title": "Host SSH is using password authentication.",
    "description": "Host SSH should not use password, as this is insecure to brute force attacks from external sources.",
    "remarks": "Migrate to using SSH Public Keys, and switch off password authentication."
}] {
	"yes" in input.passwordauthentication
}
```

## Metadata

Plugins expect policies to contain a metadata section as comments, with a `# METADATA` line to indicate it. This metadata should be in a YAML format, and contain a title and description of the policy. Other configuration can be set also, like the schedule that a policy should run on, or the control that it is linked to.

Any other comments can be added as normal (before and after) with a line separator between them and the metadata.

Here is an example metadata:
```opa
# your custom comment

# METADATA
# title: <your-title>
# description: <your-description>
# custom:
#   controls:
#     - <control-id>
#   schedule: "<cron-string>"

# your custom comment
```