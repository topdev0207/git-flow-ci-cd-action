import { GitFlowHandler } from '@/modules/git-flow/protocols';
import { GitFlowService } from '@/modules/git-flow/service';
import { BugFix, Feature, HotFix, Release } from '@/modules/git-flow/handlers';
import { GitHubFactory } from '@/infra/github/factory';
import { GitHub } from '@/infra/github/protocols/git-hub';

export class GitFlowFactory {
    private static handlers: GitFlowHandler[];

    public static assemble() {
        const github = GitHubFactory.assemble();
        this.setHandlers(github);
        const handler = this.getHandler();
        return new GitFlowService(handler);
    }

    private static setHandlers(github: GitHub): void {
        this.handlers = [
            new BugFix(github),
            new Feature(github),
            new HotFix(github),
            new Release(github),
        ];
    }

    private static getHandler(): GitFlowHandler {
        let handler = undefined;

        for (const key in this.handlers) {
            console.log(this.handlers[key]);

            if (this.handlers[key].test()) {
                handler = this.handlers[key];
            }
        }

        return handler as GitFlowHandler;
    }
}
