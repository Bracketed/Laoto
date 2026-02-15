import { DockerClient } from '@docker/node-sdk';

const images: Array<{ registry?: string; image: string; prefix: string; versions: { tag: string; alias: string }[] }> =
	[
		{
			image: 'ubuntu',
			prefix: 'ubuntu',
			versions: [
				{ tag: '22.04', alias: '22.04' },
				{ tag: '24.04', alias: '24.04' },
				{ tag: 'latest', alias: 'latest' },
			],
		},
		{
			registry: 'mcr.microsoft.com',
			image: 'windows/servercore',
			prefix: 'windows',
			versions: [
				{ tag: 'ltsc2025', alias: '2025' },
				{ tag: 'ltsc2022', alias: '2022' },
				{ tag: 'ltsc2025', alias: 'latest' },
			],
		},
	];

const docker = await DockerClient.fromDockerHost('tcp://localhost:2375');
