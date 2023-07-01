# labrador-action (alpha)

A Github action to fetch remote secrets and load them as environment variables
in a workflow, using [labrador](https://github.com/DivergentCodes/labrador).

Values are recursively pulled from one or more services, and set as
environment variables that subsequent jobs in the workflow can access.

The primary use case is enabling secretless pipelines, where secrets are
dynamically fetched from a centralized store, instead of statically stored.

## Quickstart

Make sure that your Github Actions workflow has access to the target cloud
resources, ideally using Github Action's support for
[OpenID Connect to cloud providers](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect).

Add a

```yaml
      - uses: DivergentCodes/labrador-action@v0.0.3
        with:
          # The base path that Labrador will recursively fetch parameters from.
          ssm-path-prefix: '/base/path/to/params'
```
