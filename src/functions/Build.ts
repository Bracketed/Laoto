import type { DockerClient } from '@docker/node-sdk';
import process from 'node:process';
import { createPack } from 'tar-fs';

function buildRunnerImage(docker: DockerClient, name: string) {
	docker.imageBuild(createPack(process.cwd()), {
		tag: `runners/${name}`,
		version: '2',
		dockerfile: `./images/${name}.Dockerfile`,
	});
}

export { buildRunnerImage };
