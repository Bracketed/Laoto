import { DockerClient } from '@docker/node-sdk';
import console from 'node:console';

const docker = await DockerClient.fromDockerHost('tcp://localhost:2375');
