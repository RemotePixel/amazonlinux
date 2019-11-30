
import click
from boto3.session import Session as boto3_session

regions = [
    "ap-northeast-1",
    "ap-northeast-2",
    "ap-south-1",
    "ap-southeast-1",
    "ap-southeast-2",
    "ca-central-1",
    "eu-central-1",
    "eu-north-1",
    "eu-west-1",
    "eu-west-2",
    "eu-west-3",
    "sa-east-1",
    "us-east-1",
    "us-east-2",
    "us-west-1",
    "us-west-2"
]


@click.command()
@click.argument('gdalversion', type=str)
@click.argument('pythonversion', type=str)
@click.argument('layername', type=str)
def main(gdalversion, pythonversion, layername):
    
    runtime = f"python{pythonversion}"

    gdalversion_nodot = gdalversion.replace(".", "")
    pythonversion_nodot = pythonversion.replace(".", "")
    layer_name = f"gdal{gdalversion_nodot}-py{pythonversion_nodot}-{layername}"

    session = boto3_session()

    for region in regions:
        client = session.client("lambda", region_name=region)

        layers = client.list_layer_versions(
            CompatibleRuntime=runtime,
            LayerName=layer_name,
        )
        for layer in layers.get("LayerVersions", []):
            client.delete_layer_version(
                LayerName=layer_name,
                VersionNumber=layer["Version"]
            )

            try:
                client.remove_layer_version_permission(
                    LayerName=layer_name,
                    VersionNumber=layer["Version"],
                    StatementId="make_public",
                )

            except Exception as err:
                click.echo(str(err), err=True)



if __name__ == '__main__':
    main()
