 addBlock(block) {
        block.prevHash = this.getLastBlock().hash;
        block.hash = block.getHash();
        block.mine(this.difficulty);
        this.chain.push(Object.freeze(block));

        this.difficulty += Date.now() - parseInt(this.getLastBlock().timestamp) < this.blockTime ? 1 : -1;
