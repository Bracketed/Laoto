import type { DockerClient } from '@docker/node-sdk';
import process from 'node:process';
import { createPack } from 'tar-fs';

async function buildRunnerImage(docker: DockerClient, name: string) {
	const context = createPack(process.cwd());
	const builder = await docker.imageBuild(context, {
		tag: `runners/${name}`,
		version: '2',
		dockerfile: `./images/${name}.Dockerfile`,
	});

	await new Promise<void>((resolve, reject) => {
		buildResponse.body
			.on('data', (chunk) => {
				// Each chunk is JSON status progress
				console.log(chunk.toString());
			})
			.on('end', resolve)
			.on('error', reject);
	});

	console.log('Image build complete!');
}

export { buildRunnerImage };
